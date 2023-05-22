const express = require('express');

const multer = require('multer');
const path = require('path');

const app = express();
const PORT = 3000;
const IP = '192.168.174.230';
app.use('/images',express.static('uploads/'));


const upload = multer({
    storage:multer.diskStorage({
        destination:(req,file,cb)=>{
                cb(null,'uploads/')
        },
        filename:(req,file,cb)=>{
            cb(null,`${file.fieldname}_${Date.now()}${path.extname(file.originalname)}`);
        }
    }),
}).single('uploadFile');

app.post('/upload',upload,(req,res)=>{
    if(req.file != null){
        res.json({url:`http://${IP}:${PORT}/images/${req.file.filename}`});
    }
});

app.listen(PORT,IP,() => {
    console.log("Starting....");
})
