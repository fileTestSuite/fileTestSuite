File Test Suite specification
=============================

Rationale
---------

There are various projects related to data processing, such as compression, encryption, hashing, source code transpilation, etc.

Developers of of such projects have to test such projects.

Usually testing is done in the form of pairs `<data before processing>` - `<data after processing>`.

Often such data is organized as files on the disk, where the test identifier is the name of a file, and whether the data is processed or not is given by file extension.

I.e. `a.txt` is an original file, and `a.txt.gz` or `a.gz` is the gzipped file.

Here we:

* try to unify such attempts
* provide a specification encoding different ways of organizing test files sets in the wild
* provide a libraries implementing such a specification.

This allows us to share test datasets and code between projects easily.

We can harvest test sets from various projects, merge them into a single repo, then replace in the original projects their test set to a git submodule, almost without changes in original projects.

Schema
------

A test set is a standalone repository in a version control system.

It has a root dir, which has `ReadMe.md` file, which describes the whole dataset.
It has subdirs for each standalone dataset harvested from various projects.
Each subdir contains:
* a metadata file, `meta.ftsmeta`, describing the way challenge-response pairs filenames are mapped to each other and parameters used for the algorithms;
* a `ReadMe.md` file, describing the origin of the dataset;
* a license file, if needed;
* challenge-response pairs, with filenames following the schema, described in the metadata file.

Metadata file
--------------

For the format of `meta.ftsmeta`, its semantics and the design decisions behind it see the `file_test_suite_metadata.ksy` Kaitai Struct spec.

