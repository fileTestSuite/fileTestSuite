meta:
  id: file_test_suite_metadata
  title: Metadata file for fileTestSuite
  file-extension: ftsmeta.dat
  encoding: utf8
  endian: le
  license: Unlicense
  imports:
    - file_test_suite_common

doc-ref: https://github.com/fileTestSuite/fileTestSuite

doc: |
  this file describes the dataset offile formats. It was chosen to make it binary to allow easy and efficient interaction to it from variety of programming languages. It could have been i. e. a JSON file, but it has drawbacks.
  * one needs a parser library. Of course I can try to require users to install such a library, but it is inacceptable.
  * It is too self-describtive and wastes space.
  
  So instead I have designed the custom binary format with the following goals in mind:
  * simplicity of implementing a library for parsing and serializing it.
  * minimality of space occupied in file.
  
  So
  * the format is binary, to spare you from dealing with PEG/LL/LR grammars and text parsing
  * all the lengths are usually limited to 255 (maximum value within 1 byte), so no need to deal with endianness. Such lengths should be enough for purposes of describing test datasets made by sane people, and datasets made by insane ones should be transformed into the sane state first.
  * all the strings being a null-terminated C-strings, so you can just map the file into memory and create some pointers to the needed parts.
  * all the strings that are not constant-size are prefixed with their lengths. This allows to skip them without reading their contents byte-by-byte.
  * all the formats have the header of the same format. This allows some code reuse.
  * The signature in the header is a constant-size string of length of 8 bytes, which is single u8, so string comparison is not really necessary, one can use integers for it, which is a bit more efficient on modern CPUs.
  
  Additionally this set of Kaitai Struct specs was implemented to both document the format and allow you to have some relatively-ugly auto-generated parsers for some languages for free.

seq:
  - id: header
    type: file_test_suite_common::header
    valid:
      expr: _.signature == "ftsmeta"
  - id: raw_ext
    type: file_test_suite_common::string
    doc: |
      Extension of the raw file - "challenge".
      Can be empty, in this case all files having response counterpart are considered a challenge, and response filename is got by appending challenge filename to it.
  - id: processed_ext
    type: file_test_suite_common::string
    doc: |
      Extension of the processed file - "response".
  - id: subsets_count
    type: u1
  - id: subsets
    type: files_subset
    repeat: expr
    repeat-expr: subsets_count
    doc: Subsets array.

types:
  files_subset:
    seq:
      - id: glob_mask
        type: file_test_suite_common::string
      - id: args_count
        type: u1
      - id: args
        type: arg
        repeat: expr
        repeat-expr: args_count
        doc: Arguments array.
    types:
      arg:
        seq:
          - id: id
            type: u1
            doc: identifies the argument and is impl defined. You need an arg onthology to interpret it.
          - id: size
            type: u1
          - id: value
            size: size
            doc: value of the arg in binary form.
