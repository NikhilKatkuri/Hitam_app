import fs from "fs"

fs.readdir('.', (error, files) => {
    if (error) {
        return error;
    }
    const poppinsFiles = files.filter(f => f.includes('.ttf'));
    poppinsFiles.forEach(file => console.log(`
       - asset: ${file}
           weight: 500
          ${file.includes('Italic')?'style: italic':''}`))
})