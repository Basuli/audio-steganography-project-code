close all; clear all; clc;

[FileName,PathName] = uigetfile({'.wav'}, 'Select stego audio:');
wavin = [PathName FileName];

% Load the generated key from the file
load('generatedKey.mat');

% Load the .mat file
%load('text_length.mat');
% Access the value of textLength
%disp(textLength); % Display the length value

msg = lsb_dec(wavin);
%display msg
%convert msg to a cell array of character vectors
%msgCell = cellstr(msg(:));
% Join the characters together to form one string
%msgString = strjoin(msgCell, '');
%disp(msgString);




plainText=decryptionAlgo(msg,generatedKey);

% Convert 'plainText' to a cell array of character vectors
plainTextCell = cellstr(plainText(:));
% Join the characters together to form one string
plainTextString = strjoin(plainTextCell, '');
fprintf("Retrieved message: %s\n", plainTextString);

