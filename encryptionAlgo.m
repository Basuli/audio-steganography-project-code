function ciphertext = encryptionAlgo(plaintext, K)
    % Step 1: Generate ASCII values of all the letters in the plaintext
    ascii_values = double(plaintext);
    
    % Step 2: Divide ASCII values by the key K
    quotients = floor(ascii_values / K);
    remainders = mod(ascii_values, K);
    
    % Step 3: Convert quotients and remainders into 4-bit binary representation
    binary_quotients = dec2bin(quotients, 4);
    binary_remainders = dec2bin(remainders, 4);
    
    % Step 4: Combine quotient and remainder bits for each character
    combined_binary = strcat(binary_quotients, binary_remainders);
    
    % Step 5: Convert combined binary to ASCII characters
    ciphertext = char(bin2dec(combined_binary));

   %ciphertext(plaintext == ' ') = char(128);

end


