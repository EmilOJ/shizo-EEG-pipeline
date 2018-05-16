function mpm_install() 
    path = [fileparts(which(mfilename)) filesep 'package.txt'];
    disp(path)
    mpm('install', '-i', path)
end