function msg = lsb_dec(wavin)
    % Read the stego audio file
    [stegoAudio, Fs] = audioread(wavin);
    
    % Convert stegoAudio to int16
    stegoAudio = int16(stegoAudio * (2^15));
    
    % Extract the length of the message from the first 16 samples
    msgLengthBits = zeros(1, 16);
    for i = 1:16
        msgLengthBits(i) = bitget(stegoAudio(i), 1);
    end
    msgLength = bin2dec(char(msgLengthBits + '0'));  % Convert binary length to decimal
   
    L = msgLength * 8;  % Length in bits

    % Extract the scrambled text from the audio
    scrambledTextBinary = zeros(1,L);
    for i = 1:(L)
        currentLSB = bitget(stegoAudio(i + 16), 1);
        nextLSB = bitget(stegoAudio(i + 16), 2);
        scrambledTextBinary(i) = xor(currentLSB, nextLSB);
    end
    
    % Convert the binary scrambled text back to characters
    scrambledTextChars = reshape(scrambledTextBinary, 8, [])';
    scrambledTextChars = char(bin2dec(char(scrambledTextChars + '0')));
    msg = scrambledTextChars;
    %msg = char(scrambledTextChars)';
end
