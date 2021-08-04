const session = require('express-session')
const express = require('express')
const app = express()
const fs = require('fs')
const { v4: uuidV4 } = require('uuid')

const serveroption = {
    key: fs.readFileSync('./keys/private.key'),
    cert: fs.readFileSync('./keys/private.crt')
}

const server = require('https').createServer(serveroption, app)
const io = require('socket.io')(server)


app.use(session({
    secret: 'keyboard cat',
    resave: false,
    saveUninitialized: true
}))

app.set('view engine','ejs')
app.use(express.static('public'))
app.use(express.json());
app.use(express.urlencoded({ extended: false }))

app.get('/',(req, res) => {
    res.redirect(`/${uuidV4()}`)
})

app.get('/:room', (req, res) => {
    console.log(req.session.member)
    console.log(req.session.business)
    res.render('room',{ roomId: req.params.room,
    member:  req.session.member,
    business:  req.session.business})
})



app.post('/',(req, res)=>{
   req.session.member = req.body.member
   req.session.business = req.body.business
   console.log("m"+req.session.member)
   console.log("b"+req.session.business)
   res.redirect(`/${uuidV4()}`)
})

io.on('connection', socket =>{
    socket.on('join-room',(roomId,userId)=>{
        socket.join(roomId)
        socket.broadcast.to(roomId).emit("user-connected", userId)

        socket.on('disconnect', ()=>{
            socket.broadcast.to(roomId).emit('user-disconnected',
            userId)
        })
    })
})

server.listen(3000)
