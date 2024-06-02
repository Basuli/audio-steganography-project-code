function K = generateKey(password)
    % Step 1: Find the length n of the string
    n = numel(password);
    
    % Step 2: Generate a random number r between 1 and n
    r = randi(n);
    
    % Step 3: Go to the rth character of the string
    character = password(r);
    
    % Step 4: Get the ASCII value for the rth character
    ascii_value = double(character);
    
    % Step 5: Generate the 8 bit binary value
    binary_value = dec2bin(ascii_value, 8);
    %disp(binary_value);
    % Initialize key
    key = -1;
    
    % Iterate over consecutive 4-bit segments
    for i = 1:5 % Iterate through the 5 segments
        % Calculate start and end indices for the current segment
        start_index = i;
        end_index = i + 3;
        
        % Ensure end_index does not exceed 8
        if end_index > 8
            end_index = 8;
        end
        
        % Extract the 4-bit segment
        segment = binary_value(start_index:end_index);
        
        % Convert the segment to decimal
        segment_dec = bin2dec(segment);
        
        % Check if the segment meets the condition
        if segment_dec >= 8
            key = segment_dec;
            
            break; % Exit loop if condition is met
        end
    end

    
    
    % If key is not found, generate it recursively
    if key == -1
        key = generateKey(password);
    end
    
    % Return the generated key
    K = key;
end
