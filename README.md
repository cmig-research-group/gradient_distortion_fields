# Gradient distortion fields

Gradient nonlinearity distortion fields for MRI scanners, used to correct
images for the geometric distortion caused by gradient nonlinearity.

## Contents

- `<vendor>_<gradient>_d{L,P,H}.mgh`: for each of 21 gradient types, the
  distortion fields along the RL, AP and IS axes (63 files)
- `gradient_distortion_files.m`, `gradient_distortion_files.py`: the three
  field files and the name of a gradient type (0-20, listed in the help of
  either); the two give the same files for each type. Both look for the
  files in the directory named by `GRADIENT_DISTORTION_FIELDS_DIR`, if set,
  else beside the code.

The CMIG BIDS pipeline (cmig_pipeline) reads the fields from a release tag
of this repository.

## Credits

The fields and the original code (mmil_grad_files.m) were made at UC San
Diego; the Siemens Aera XJ and XQ fields by Christopher Conlin (UC San
Diego, 2025). The python version and the changes since April 2025 were
made at the J. Craig Venter Institute.

## License

Non-commercial use only. The fields and the code written at UC San Diego
are under UC San Diego's notice; the code written since at the J. Craig
Venter Institute is under the PolyForm Noncommercial License 1.0.0. See
LICENSE.txt.
