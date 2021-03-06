%% set path for your computer

currentFolder = pwd;
objFolder = '/home/yutaochen/Documents/MATLAB/Packages/MATMPC/mex_core';

if ~strcmp(currentFolder, objFolder)
    cd /home/yutaochen/Documents/MATLAB/Packages/MATMPC/mex_core
end

%% detect OS type

OS_MAC = 0;
OS_LINUX = 0;
OS_WIN = 0;

if ismac
    OS_MAC = 1;
elseif isunix
    OS_LINUX = 1;
elseif ispc
    OS_WIN = 1;
else
    disp('Platform not supported')
end

%% Configure Compiler

options = '-largeArrayDims';

if OS_WIN
   CC_FLAGS='';
end
if OS_LINUX 
   CC_FLAGS = 'GCC="/usr/bin/gcc-4.9"';
end

OP_FLAGS='';

LIB1 = '-lmwblas';
LIB2 = '-lmwlapack';
% LIB3 = '-lopenblas';
% LIB4 = '-lblasfeo';
% LIB5 = '-lqpOASES_e';

LIB1_PATH = '';
LIB2_PATH = '';
% LIB3_PATH = '-L/home/yutaochen/Downloads/OpenBLAS/build/lib';
% LIB4_PATH = '-L/home/yutaochen/Documents/MATLAB/Packages/blasfeo/lib';
% LIB5_PATH = '-L/home/yutaochen/Documents/MATLAB/Packages/qpOASES_C/qpOASES/build/lib';

HEAD1_PATH = '';
HEAD2_PATH = '';
% HEAD3_PATH = '-I/home/yutaochen/Downloads/OpenBLAS/build/include';
% HEAD4_PATH='-I/home/yutaochen/Documents/MATLAB/Packages/blasfeo/include';
% HEAD5_PATH='-I/home/yutaochen/Documents/MATLAB/Packages/qpOASES_C/qpOASES/include';
%% These functions should be all compiled

mex(options, OP_FLAGS, CC_FLAGS, HEAD1_PATH, LIB1_PATH, 'qp_generation.c','casadi_wrapper.c','sim.c','casadi_src.c',LIB1,LIB2);

mex(options, CC_FLAGS, OP_FLAGS, 'Condensing.c', LIB1);

mex(options, OP_FLAGS, CC_FLAGS, HEAD1_PATH, LIB1_PATH,'Recover.c', LIB1);

mex(options, OP_FLAGS, CC_FLAGS, HEAD1_PATH, LIB1_PATH,'solution_info.c','casadi_wrapper.c','casadi_src.c','sim.c', LIB1, LIB2);

mex(options, OP_FLAGS, CC_FLAGS, HEAD1_PATH, LIB1_PATH,'Line_search.c', LIB1);

%% only for testing, don't touch

% mex(options, OP_FLAGS, CC_FLAGS, HEAD4_PATH, LIB4_PATH, LIB4, 'blasfeo.c');

% mex(options, OP_FLAGS, CC_FLAGS, HEAD5_PATH, LIB5_PATH, LIB5, 'qpoases_c.c');

% mex(options, OP_FLAGS, CC_FLAGS, HEAD5_PATH, LIB5_PATH, LIB5, 'qpoases_hotstart.c');