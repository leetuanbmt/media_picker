let port = process.env.PORT || 1995;

let IO = require("socket.io")(port, {
  cors: {
    origin: "*",
    methods: ["GET", "POST"],
  },
});

IO.use((socket, next) => {
  if (socket.handshake.query) {
    let callerId = socket.handshake.query.callerId;
    socket.user = callerId;
    next();
  }
});

IO.on("connection", (socket) => {

  console.log(socket.user, "Connected to socket");

  socket.join(socket.user);

  socket.on("makeCall", (data) => {


    let calleeId = data.calleeId;

    let sdpOffer = data.sdpOffer;


    socket.to(calleeId).emit("newCall", {
      callerId: socket.user,
      sdpOffer: sdpOffer,
    });
  });

  socket.on("endCall", (data) => {
    let callerId = data.callerId;
    socket.to(callerId).emit("callEnded");
  });

  socket.on("answerCall", (data) => {

    let callerId = data.callerId;

    let sdpOffer = data.sdpOffer;


    socket.to(callerId).emit("callAnswered", {
      callerId: socket.user,
      sdpOffer: sdpOffer,
    });
  });

  socket.on("iceCandidate", (data) => {

    let calleeId = data.calleeId;

    let iceCandidate = data.iceCandidate;


    socket.to(calleeId).emit("iceCandidate", {
      calleeId: socket.user,
      iceCandidate: iceCandidate,
    });
  });

  socket.on("disconnect", () => {
    socket.leave(socket.user);
    console.log(socket.user, "Disconnected from socket");
  });

});