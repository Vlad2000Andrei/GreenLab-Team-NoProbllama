const fs = require('fs');

function processData(input) {
  var lines = input.split('\n');
  var n = parseInt(lines.shift(), 10);
  var data = (
       lines
      .shift()
      .split(' ')
      .splice(0, n)
      .map(function (s, i, a) { return parseInt(s, 10); })
  );

  var res = (
       data
      .sort(function (o1, o2) { return o1 - o2; })
      .reduce(
          function (prev, cur, i, a) {
              if (i == 0) { return prev; }
              var diff = Math.abs(a[i - 1] - cur);

              if (prev.diff == null || diff < prev.diff) {
                  prev.diff = diff;
                  prev.sols = [];
                  prev.sols.push({n1:a[i - 1], n2:cur});
              } else if (diff == prev.diff) {
                  prev.sols.push({n1:a[i - 1], n2:cur});
              }
                  return prev;
          }
          , { diff:null, sols:[] }
      )
  );
  res.sols.forEach(function (sol, i, a) {
      // if (i > 0) { process.stdout.write(' '); }
      process.stdout.write(sol.n1 + ' ' + sol.n2 + ' ');
      if (i == a.length - 1) { process.stdout.write('\n'); }
  });
}

const data = fs.readFileSync('./experiment-runner/energy/smallnumbers.txt', 'utf8');

processData(data);