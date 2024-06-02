function lsb_enc(wavin, wavout, scrambledText)
    % Read the cover audio file
    [coverAudio, Fs] = audioread(wavin);

    % Plot the audio signal
        t = (0:length(coverAudio)-1) / Fs;  % Time vector
        subplot(2,1,1); % Create subplot for the original signal
        plot(t, coverAudio);
        xlabel('Time (s)');
        ylabel('Amplitude');
        title('Audio Signal before encryption');

    % Convert coverAudio to int16
    coverAudio = int16(coverAudio * (2^15));
    
    % Get the length of the message
    msgLength = length(scrambledText);
   
    L=msgLength*8;
    
    % Check if message can fit in the cover audio
    if L + 16 > length(coverAudio)
        error('Message is too big, select a smaller message.');
    end

    % Convert the message length to 16-bit binary array
    msgLengthBits = dec2bin(msgLength, 16) - '0';  % Convert length to 16-bit binary array

    % Convert the scrambledText to binary
    scrambledTextBinary = reshape(dec2bin(scrambledText, 8)', 1, []);  % Convert to binary string
    
    % Embed the length in the first 16 samples
    for i = 1:16
        coverAudio(i) = bitset(coverAudio(i), 1, msgLengthBits(i));
    end
    
    % Embed the scrambled text starting from the 17th sample
    for i = 1:L
        % Get the current bit to embed
        bitToEmbed = str2double(scrambledTextBinary(i));
        
        % Get the current LSB of the sample
        currentLSB = bitget(coverAudio(i + 16), 1);
        
        % Get the next LSB of the sample
        nextLSB = bitget(coverAudio(i + 16), 2);
        
        % Check the XOR condition and adjust the LSB accordingly
        if bitToEmbed == 0
            if xor(currentLSB, nextLSB) ~= 0
                coverAudio(i + 16) = bitxor(coverAudio(i + 16), 1);  % Flip LSB
            end
        else
            if xor(currentLSB, nextLSB) ~= 1
                coverAudio(i + 16) = bitxor(coverAudio(i + 16), 1);  % Flip LSB
            end
        end
    end
    % Write the modified audio to a new file
    audiowrite(wavout, double(coverAudio) / (2^15), Fs);
    fprintf('encrypted file saved');
    
    % Plot the audio signal

    % Read audio file to get audio signal and sampling frequency
    [audio_out, Fs] = audioread(wavout);
    t = (0:length(audio_out)-1) / Fs;  % Time vector
    subplot(2,1,2); % Create subplot for the encrypted signal
    plot(t, audio_out);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title('Audio Signal after encryption');



    %playing media
    % Read the audio file(before encryption)
    %[y, Fs] = audioread(wavin);
    % Play the audio
    %sound(y, Fs);
    
    % Read the audio file(after encryption)
    %[x, Fs] = audioread(wavout);
    % Play the audio
    %sound(x, Fs);

end
