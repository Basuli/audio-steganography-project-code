function plaintext = decryptionAlgo(ciphertext, K)
    %ciphertext(ciphertext == char(128)) = ' ';
    % Convert ciphertext to ASCII values
    ascii_values = double(ciphertext);
    
    % Step 1: Reverse all the 8-bit numbers
    reversed_ciphertext = fliplr(ascii_values);
    
    % Step 2: Extract 4 MSB bits and 4 LSB bits
    num_chars = numel(reversed_ciphertext);
    msb = cell(1, num_chars);
    lsb = cell(1, num_chars);
    for i = 1:num_chars
        ascii_binary = dec2bin(reversed_ciphertext(i), 8);
        msb{i} = ascii_binary(1:4);
        lsb{i} = ascii_binary(5:8);
    end
    
    % Step 3: Convert MSB and LSB to decimal values
    msb_decimal = bin2dec(msb);
    lsb_decimal = bin2dec(lsb);
    
    % Step 4: Multiply MSB by the Key K
    multiplied_msb = msb_decimal * K;
    
    % Step 5: Add LSB to the multiplied MSB
    result_decimal = multiplied_msb + lsb_decimal;
    
    % Step 6: Convert result to ASCII characters
    plaintext = char(result_decimal);
    %disp(plaintext);
     % Step 7: Restore spaces
    %plaintext(plaintext == char(128)) = ' ';
    %plaintext(result_decimal == 0) = ' ';
    %plaintext(result_decimal < 32) = ' ';
end
