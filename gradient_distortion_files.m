function [fname_gradL,fname_gradP,fname_gradH,grad_unwarp] = gradient_distortion_files(gradient_type)
%function [fname_gradL,fname_gradP,fname_gradH,grad_unwarp] = gradient_distortion_files(gradient_type)
%
% Purpose: return the gradient nonlinearity distortion field files for a
%   gradient type
%
% Input:
%
%   gradient_type: 0:  Siemens Sonata
%                  1:  Siemens Allegra
%                  2:  GE BRM
%                  3:  GE CRM
%                  4:  Siemens Avanto
%                  5:  Siemens AXXess/Espree
%                  6:  Siemens Quantum/Symphony
%                  7:  GE Twin Speed Whole Body
%                  8:  GE Twin Speed Zoom
%                  9:  GE MR450 or MR750
%                  10: GE MR750W
%                  11: Siemens Skyra
%                  12: Siemens Connectome Skyra
%                  13: Siemens Prisma
%                  14: GE Signa Premier
%                  15: GE Signa UHP
%                  16: Siemens Verio/Biograph
%                  17: Siemens Vida
%                  18: Siemens Cima.X
%                  19: Siemens Aera XJ
%                  20: Siemens Aera XQ
%
% Output:
%
%   fname_gradL: full path of the distortion field file for RL
%   fname_gradP: full path of the distortion field file for AP
%   fname_gradH: full path of the distortion field file for IS
%   grad_unwarp: gradient type name
%
% The files are found in the directory named by the environment variable
%   GRADIENT_DISTORTION_FIELDS_DIR, if set and the files are there,
%   otherwise in the directory of this function (where the files are kept
%   in the gradient_distortion_fields repository). A compiled application
%   does not include the files, so it needs the environment variable.
%
% A python version, gradient_distortion_files.py, gives the same files for
%   each gradient type; a change to either needs the same change to the other
%
% Created:  10/22/2026 by Don Hagler
% Last Mod: 10/22/2026 by Don Hagler
%

% Based on mmil_grad_files (MMPS), with the Aera XJ and XQ types of
%   cmig_core_utils
% Created:  12/03/2021 by Don Hagler
% Last Mod: 12/09/2024 by Don Hagler

fname_gradL = []; fname_gradP = []; fname_gradH = []; grad_unwarp = [];

if nargin < 1
  error('gradient_type is required');
end

switch gradient_type
  case 0
    fstem = 'siemens_sonata';
    grad_unwarp = 'Siemens_Sonata';
  case 1
    fstem = 'siemens_allegra';
    grad_unwarp = 'Siemens_Allegra';
  case 2
    fstem = 'ge_brm';
    grad_unwarp = 'GE_BRM';
  case 3
    fstem = 'ge_crm';
    grad_unwarp = 'GE_CRM';
  case 4
    fstem = 'siemens_avanto';
    grad_unwarp = 'Siemens_Avanto';
  case 5
    fstem = 'siemens_axxess';
    grad_unwarp = 'Siemens_Axxess';
  case 6
    fstem = 'siemens_quantum';
    grad_unwarp = 'Siemens_Quantum';
  case 7
    fstem = 'ge_whole';
    grad_unwarp = 'GE_WHOLE';
  case 8
    fstem = 'ge_zoom';
    grad_unwarp = 'GE_ZOOM';
  case 9
    fstem = 'ge_xrmb';
    grad_unwarp = 'GE_XRMB';
  case 10
    fstem = 'ge_xrmw';
    grad_unwarp = 'GE_XRMV';
  case 11
    fstem = 'siemens_skyra';
    grad_unwarp = 'Siemens_Skyra';
  case 12
    fstem = 'siemens_connectome';
    grad_unwarp = 'Siemens_Connectome';
  case 13
    fstem = 'siemens_prisma';
    grad_unwarp = 'Siemens_Prisma';
  case 14
    fstem = 'ge_HRMw';
    grad_unwarp = 'GE_HRMW';
  case 15
    fstem = 'ge_HRMB2';
    grad_unwarp = 'GE_HRMB2';
  case 16
    fstem = 'siemens_verio';
    grad_unwarp = 'Siemens_Verio';
  case 17
    fstem = 'siemens_vida';
    grad_unwarp = 'Siemens_Vida';
  case 18
    fstem = 'siemens_CimaX';
    grad_unwarp = 'Siemens_CimaX';
  case 19
    fstem = 'siemens_AeraXJ';
    grad_unwarp = 'Siemens_AeraXJ';
  case 20
    fstem = 'siemens_AeraXQ';
    grad_unwarp = 'Siemens_AeraXQ';
  otherwise
    error('unsupported gradient type %d',gradient_type);
end

% the environment variable, then the directory of this function
envdir = getenv('GRADIENT_DISTORTION_FIELDS_DIR');
owndir = fileparts(mfilename('fullpath'));
indir = [];
if ~isempty(envdir) && all_exist(envdir,fstem)
  indir = envdir;
elseif all_exist(owndir,fstem)
  indir = owndir;
end
if isempty(indir)
  error('distortion field files %s_d{L,P,H}.mgh not found in GRADIENT_DISTORTION_FIELDS_DIR (%s) or %s',...
    fstem,envdir,owndir);
end

fname_gradL = sprintf('%s/%s_dL.mgh',indir,fstem);
fname_gradP = sprintf('%s/%s_dP.mgh',indir,fstem);
fname_gradH = sprintf('%s/%s_dH.mgh',indir,fstem);

return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function flag = all_exist(indir,fstem)
  flag = exist(sprintf('%s/%s_dL.mgh',indir,fstem),'file') &&...
         exist(sprintf('%s/%s_dP.mgh',indir,fstem),'file') &&...
         exist(sprintf('%s/%s_dH.mgh',indir,fstem),'file');
return;
