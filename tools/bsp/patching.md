# BSP patching library

The included patching library, [`bsppatch.js`](bsppatch.js), implements the [BSP specification](specification.md) and
therefore allows applying a BSP according to it. While it is not a full application on its own, it can be used by
implementors to create one.

The library defines a single class, BSPPatcher, which permits applying a BSP. The class is defined in the scope of the
file, that is, this way, without involving any module-like structure:

```javascript
function BSPPatcher (bsp_array_buffer, input_array_buffer) {
  // code here
}
```

The library uses mostly ECMAScript 5 features; however, it uses [Typed Arrays][typed-arrays] from ECMAScript 6. The
practical implication of this is that the library will work in any modern browser or Node.js version, but most likely
not in Internet Explorer (although it may work in IE10+ due to some added support for Typed Arrays).

[typed-arrays]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Typed_arrays

The constructor, properties and methods of the `BSPPatcher` class are documented here.

## Constructor

```javascript
var bsp = new BSPPatcher(bsp_array_buffer, input_array_buffer);
```

This creates a new BSPPatcher object, with the corresponding BSP and input file. The BSP and the input are passed to
the constructor as ArrayBuffer objects containing the data of the respective files.

## Callback properties

These properties are modifiable by the user of the library, and they are expected to contain callbacks that will be
called in various circumstances. Their initial value is `undefined`, and when any of the properties is set to this
value, the corresponding callback will not be called when the event occurs. These callback properties are:

* `print`: called whenever a `print` instruction is encountered in the BSP, in order to print a message to the user. It
  is passed a single argument, which is the string to be printed. The callback must call the `run()` method of the
  BSPPatcher object after it is done printing to continue executing the BSP (which can happen asynchronously, since the
  `run()` method is asynchronous anyway). If the `print` property of the BSPPatcher object is set to `undefined` and a
  `print` instruction is encountered, an error will occur.
* `menu`: called whenever a `menu` instruction is encountered in the BSP, in order to display a menu for the user to
  select an option. It is passed a single argument, which is an array of strings, each string containing one option;
  the user will have to select one of these options for the patching process to continue. After the user selects an
  option, the `run()` method of the BSPPatcher object must be called, passing the index of the selected option (which
  is the index of the corresponding string in the array passed to the `menu`callback) in order for the patching process
  to continue. If the `menu` property of the BSPPatcher object is set to `undefined` and a `menu` instruction is
  encountered, an error will occur.
* `success`: called when the patching process finishes and exits with an exit status of 0, indicating that the patching
  succeeded. It is passed a single argument, which is an ArrayBuffer object containing the output data of the patch.
  This callback should be used to store the data in a file or otherwise make it available to the end user.
* `failure`: called when the patching process finishes with a non-zero exit status, indicating failure. It is passed a
  single argument, which is the exit status. This callback should be used to report to the end user that the patching
  script reported an error.
* `error`: called when the patching process throws an exception. It is passed a single argument, which is the exception
  that was thrown; errors in the patching process (such as undefined instructions) throw strings as exceptions. This
  callback should also be used to report the error to the end user.

## Read-only properties

These properties are used to query the status of the patching process. They can be used instead of (or in addition to)
the `success`, `failure` and `error` callbacks to check the status of the process.

* `state`: it is an integer showing the current status of the patcher. 0 indicates that the patching process hasn't
  been started yet (and can be started with `run()`), 1 indicates that it is on-going (and can thus be resumed with
  `run()`), and higher values indicate that the process is done and cannot be restarted or resumed: 2 if an error
  occurs, 3 if the script exits with a non-zero exit status (indicating failure) or 4 if the script exits with a zero
  exit status (indicating success).
* `result`: it is the result of the patching process, which is the same value that is passed to the `error`, `failure`
  and `success` callbacks explained above. This property will be set according to the value of the `state` property,
  containing the result value for the corresponding state (i.e., the value that would be passed to the corresponding
  callback, since there is a one-to-one mapping between the callbacks and the higher values of the `state` property).
  This property is meaningless when `state` is 0 or 1, and therefore will be set to `undefined` in that case.

## `run()` method

This class defines only one method, the `run()` method, which is used both to start and to resume the patching process.
The method only takes an argument when the patcher is waiting to be resumed after a `menu` callback, in which case the
argument is the index of the selected option (between 0 and one less than the number of options, as it is usual for
array indices); otherwise, it takes no arguments.

The `run()` method will always execute asynchronously; it returns immediately and executes the patching asynchronously.
However, this asynchronous call may block the thread for a long time, since it will continue to run uninterrupted until
an I/O instruction (`print` or `menu`) is executed or until the patching process finishes; this must be taken into
consideration when using the library.
