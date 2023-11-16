import { readFile, writeFile } from 'fs/promises';

const replaceContent = async (filePath, oldContent, newContent) => {
  const file = await readFile(filePath, 'utf8');
  const updatedFile = file.replace(oldContent, newContent);
  // Write the new contents
  await writeFile('out.txt', updatedFile);
}

(async () => {
  const filePath = process.argv[2];
  const oldContent = process.argv[3];
  const newContent = process.argv[4];
  try {
    await replaceContent(filePath, oldContent, newContent);
  }
  catch (err) {
    console.error(err);
  }
})();