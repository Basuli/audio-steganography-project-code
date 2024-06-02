close all; clear all; clc;

[FileName,PathName] = uigetfile({'.wav'}, 'Select cover audio:');
[file.path,file.name,file.ext] = fileparts([PathName FileName]);

wavin = [PathName FileName];
wavout = [file.path '\' file.name '_stego' file.ext];




password = 'mypassword';

generatedKey=generateKey(password);
% Save the generated key to a file
save('generatedKey.mat', 'generatedKey');
disp("key generated successfully");
%disp(generatedKey);

file = 'secret message.txt';
fid  = fopen(file, 'r');
text = fread(fid,'*char')';
fclose(fid);

%encryption algorithm for cipher text
scrambledText=encryptionAlgo(text,generatedKey);


%for displaying scrambled text
% Convert 'scrambledText' to a cell array of character vectors
%scrambledTextCell = cellstr(scrambledText(:));
% Join the characters together to form one string
%scrambledTextString = strjoin(scrambledTextCell, '');
%disp(scrambledTextString);
%end of that








lsb_enc(wavin, wavout, scrambledText);