#!/usr/bin/env python3
"""
Return the gradient nonlinearity distortion field files for a gradient type.

The python version of gradient_distortion_files.m; both give the same files
for each gradient type, and a change to either needs the same change to the
other.

The files are found in the directory named by the environment variable
GRADIENT_DISTORTION_FIELDS_DIR, if set and the files are there, otherwise in
the directory of this script (where the files are kept in the
gradient_distortion_fields repository).

Usage as a module:
  from gradient_distortion_files import gradient_distortion_files
  fname_L, fname_P, fname_H, grad_unwarp = gradient_distortion_files(13)

Usage as a script (prints the three files and the type name):
  gradient_distortion_files.py <gradient_type>

Created:  10/22/2026 by Don Hagler
Last mod: 10/22/2026 by Don Hagler
"""

import os
import sys

ENV_DIR = 'GRADIENT_DISTORTION_FIELDS_DIR'

# gradient type: (file stem, type name)
GRADIENT_TYPES = {
    0: ('siemens_sonata', 'Siemens_Sonata'),          # Siemens Sonata
    1: ('siemens_allegra', 'Siemens_Allegra'),        # Siemens Allegra
    2: ('ge_brm', 'GE_BRM'),                          # GE BRM
    3: ('ge_crm', 'GE_CRM'),                          # GE CRM
    4: ('siemens_avanto', 'Siemens_Avanto'),          # Siemens Avanto
    5: ('siemens_axxess', 'Siemens_Axxess'),          # Siemens AXXess/Espree
    6: ('siemens_quantum', 'Siemens_Quantum'),        # Siemens Quantum/Symphony
    7: ('ge_whole', 'GE_WHOLE'),                      # GE Twin Speed Whole Body
    8: ('ge_zoom', 'GE_ZOOM'),                        # GE Twin Speed Zoom
    9: ('ge_xrmb', 'GE_XRMB'),                        # GE MR450 or MR750
    10: ('ge_xrmw', 'GE_XRMV'),                       # GE MR750W
    11: ('siemens_skyra', 'Siemens_Skyra'),           # Siemens Skyra
    12: ('siemens_connectome', 'Siemens_Connectome'), # Siemens Connectome Skyra
    13: ('siemens_prisma', 'Siemens_Prisma'),         # Siemens Prisma
    14: ('ge_HRMw', 'GE_HRMW'),                       # GE Signa Premier
    15: ('ge_HRMB2', 'GE_HRMB2'),                     # GE Signa UHP
    16: ('siemens_verio', 'Siemens_Verio'),           # Siemens Verio/Biograph
    17: ('siemens_vida', 'Siemens_Vida'),             # Siemens Vida
    18: ('siemens_CimaX', 'Siemens_CimaX'),           # Siemens Cima.X
    19: ('siemens_AeraXJ', 'Siemens_AeraXJ'),         # Siemens Aera XJ
    20: ('siemens_AeraXQ', 'Siemens_AeraXQ'),         # Siemens Aera XQ
}


def _all_exist(indir, fstem):
    return all(os.path.isfile(os.path.join(indir, '%s_d%s.mgh' % (fstem, a)))
               for a in 'LPH')


def gradient_distortion_files(gradient_type):
    """Return (fname_gradL, fname_gradP, fname_gradH, grad_unwarp)."""
    if gradient_type not in GRADIENT_TYPES:
        raise ValueError('unsupported gradient type %s' % gradient_type)
    fstem, grad_unwarp = GRADIENT_TYPES[gradient_type]
    envdir = os.environ.get(ENV_DIR, '')
    owndir = os.path.dirname(os.path.abspath(__file__))
    if envdir and _all_exist(envdir, fstem):
        indir = envdir
    elif _all_exist(owndir, fstem):
        indir = owndir
    else:
        raise FileNotFoundError(
            'distortion field files %s_d{L,P,H}.mgh not found in %s (%s) or %s'
            % (fstem, ENV_DIR, envdir, owndir))
    fnames = [os.path.join(indir, '%s_d%s.mgh' % (fstem, a)) for a in 'LPH']
    return fnames[0], fnames[1], fnames[2], grad_unwarp


def main():
    if len(sys.argv) != 2:
        sys.exit('Usage: gradient_distortion_files.py <gradient_type>')
    for v in gradient_distortion_files(int(sys.argv[1])):
        print(v)


if __name__ == '__main__':
    main()
