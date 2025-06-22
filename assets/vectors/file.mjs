import fs from "fs";

try {
    const files = fs.readdirSync("./");
    console.log(files);
    files.forEach(e => console.log(e))

} catch (err) {
    console.log(err);
}