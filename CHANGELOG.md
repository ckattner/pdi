# 2.1.0 (May 28th, 2020)

Enhancements:
 * Support for streamed output...

# 2.0.0 (May 11th, 2020)

Breaking Changes:

* Standard error and output have been combined into one stream (out).  Early feedback indicated that reading both at the same time was preferable.

Enhancements:

* Added optional `timeout_in_seconds` argument to Pdi::Spoon#initialize.

# 1.0.1 (February 19th, 2020)

Fixes:

* It now properly calls kitchen for jobs (it was previously calling pan.)

# 1.0.0 (February 19th, 2020)

Initial release.
