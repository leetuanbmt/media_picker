const WebSocket = require("ws");

const port = process.env.PORT || 1995;
const server = new WebSocket.Server({ port });
const url = require("url");
server.on("listening", () => {
  console.log("WebSocket server listening on port", port);
});

const connections = new Map();

server.on("connection", (socket, req) => {
  const queryObject = url.parse(req.url, true).query;

  socket.user = queryObject.callerId;

  connections.set(socket.user, socket);

  console.log("New connection", socket.user);

  socket.on("message", (message) => {
    const data = JSON.parse(message);

    if (data.type === "makeCall") {
      const calleeId = data.calleeId;
      const sdpOffer = data.sdpOffer;

      console.log("makeCall", calleeId);

      const calleeSocket = connections.get(calleeId);

      if (calleeSocket) {
        calleeSocket.send(
          JSON.stringify({
            type: "newCall",
            data: {
              callerId: socket.user,
              sdpOffer: sdpOffer,
            },
          })
        );
      }
    } else if (data.type === "endCall") {
      const callerId = data.callerId;
      const callerSocket = connections.get(callerId);
      if (callerSocket) {
        callerSocket.send(
          JSON.stringify({ type: "callEnded", data: { callerId: socket.user } })
        );
      }
    } else if (data.type === "answerCall") {
      const callerId = data.callerId;
      const sdpOffer = data.sdpOffer;

      const callerSocket = connections.get(callerId);
      if (callerSocket) {
        callerSocket.send(
          JSON.stringify({
            type: "callAnswered",
            data: {
              callerId: socket.user,
              sdpOffer: sdpOffer,
            },
          })
        );
      }
    } else if (data.type === "iceCandidate") {
      const calleeId = data.calleeId;
      const iceCandidate = data.iceCandidate;

      const calleeSocket = connections.get(calleeId);
      if (calleeSocket) {
        calleeSocket.send(
          JSON.stringify({
            type: "iceCandidate",
            data: {
              calleeId: socket.user,
              iceCandidate: iceCandidate,
            },
          })
        );
      }
    }
  });

  socket.on("close", () => {
    console.log("Connection closed");
    connections.delete(socket.user);
  });
});
