var fs = require("fs");
var rl = require("readline").createInterface({input: process.stdin, output: process.stdout});

// using eval() on an external value for a side effect is one of the ugliest programming tricks I've used. I don't feel guilty.
eval(fs.readFileSync("bsppatch.js", "utf-8"));

process.exitCode = 0;
try {
  if (process.argv.length != 5) {
    console.log("Error: patch, source and target files must be passed as command-line arguments");
    throw 1;
  }
  var patch_file = new Uint8Array(fs.readFileSync(process.argv[2])).buffer;
  var source_file = new Uint8Array(fs.readFileSync(process.argv[3])).buffer;
  var patch = new BSPPatcher(patch_file, source_file);
  patch.print = function (string) {
    console.log(string);
    patch.run();
  }
  patch.menu = function (entries) {
    var max_entry = entries.length;
    var entry;
    for (entry = 0; entry < max_entry; entry ++) console.log((entry + 1).toString() + ". " + entries[entry]);
    var callback = function (option) {
      if (!(/^[0-9]+$/.test(option))) return rl.question("Invalid number. Select an option: ", callback);
      var numeric_option = parseInt(option, 10);
      if ((option < 1) || (option > max_entry)) return rl.question("Invalid option selected. Select an option: ", callback);
      patch.run(numeric_option - 1);
    }
    rl.question("Select an option: ", callback);
  }
  patch.error = function (error) {
    console.log("Error: " + error.toString());
    process.exitCode = 1;
    rl.close();
  }
  patch.failure = function (status) {
    console.log("Patch exited with exit status " + status.toString());
    process.exitCode = (status > 127) ? 127 : status;
    rl.close();
  }
  patch.success = function (data) {
    rl.close();
    try {
      fs.writeFileSync(process.argv[4], Buffer.from(data));
    } catch (e) {
      console.log("Error writing output: " + e.toString());
    }
  }
  patch.run();
} catch (e) {
  if (typeof e !== "number") throw e;
  process.exitCode = e;
  rl.close();
}
