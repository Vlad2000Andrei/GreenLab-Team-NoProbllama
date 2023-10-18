
function findTwoElements(arr, k) {
  for (let i = 0; i < arr.length; i++) {
    for (let j = i + 1; j < arr.length; j++) {
      if (arr[i] + arr[j] == k) {
        console.log(`Indices of x and y: ${i}, ${j}`);
        return;
      }
    }
  }
  console.log("No elements found that add up to k");
}