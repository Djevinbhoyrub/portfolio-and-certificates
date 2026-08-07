clear; clc; close all;

selectedTech = '';   % nothing chosen yet
signal = NaN;
throughput = NaN;
utilisation = NaN;
quality = 'N/A';
status = 'N/A';

keepRunning = true;
while keepRunning
    disp('==== MOBILE SIGNAL SIMULATOR ====');
    disp('1. Select Network Technology');
    disp('2. Signal Strength Calculator');
    disp('3. Throughput Calculator');
    disp('4. User Capacity Check');
    disp('5. Network Summary');
    disp('6. Exit');
    choice = input('Enter your choice: ');

    switch choice
        case 1
            disp(' ');
            disp('1. 4G LTE');
            disp('2. 5G NR');
            techChoice = input('Choose technology (1 or 2): ');
            if techChoice == 1
                selectedTech = '4G';
                disp('You selected 4G LTE.');
            elseif techChoice == 2
                selectedTech = '5G';
                disp('You selected 5G NR.');
            else
                disp('Invalid choice, please try again.');
            end

       case 2
            if isempty(selectedTech)
                disp('Please select a network technology first (Option 1).');
            else
                dist = input('Enter distance from BS (m): ');

                if strcmp(selectedTech, '4G')
                    signal = 100 - (dist / 20);
                else
                    signal = 100 - (dist / 15);
                end

                if signal < 0
                    signal = 0;   % signal can't go negative
                end

                if signal >= 80
                    quality = 'Excellent';
                elseif signal >= 60
                    quality = 'Good';
                elseif signal >= 40
                    quality = 'Fair';
                else
                    quality = 'Poor';
                end

                fprintf('Signal Strength: %.1f%% (%s)\n', signal, quality);
            end
        case 3
            bandwidth = input('Enter bandwidth (MHz): ');
            efficiency = input('Enter spectral efficiency (bits/s/Hz): ');

            throughput = bandwidth * efficiency;

            fprintf('Estimated Throughput: %.2f Mbps\n', throughput);
        case 4
            if isempty(selectedTech)
                disp('Please select a network technology first (Option 1).');
            else
                if strcmp(selectedTech, '4G')
                    capacity = 200;
                else
                    capacity = 1000;
                end

                users = input('Enter number of connected users: ');

                utilisation = (users / capacity) * 100;

                if utilisation < 80
                    status = 'Normal';
                elseif utilisation <= 100
                    status = 'Busy';
                else
                    status = 'Overloaded';
                end

                fprintf('Utilisation: %.1f%% (%s)\n', utilisation, status);
            end

        case 5
            fprintf('\n==== NETWORK SUMMARY ====\n');
            if isempty(selectedTech)
                fprintf('Technology: Not selected yet\n');
            else
                fprintf('Technology: %s\n', selectedTech);
            end
            fprintf('Signal Strength: %.1f%% (%s)\n', signal, quality);
            fprintf('Throughput: %.2f Mbps\n', throughput);
            fprintf('User Capacity Utilisation: %.1f%% (%s)\n', utilisation, status);        case 6
            disp('Exiting program. Goodbye!');
            keepRunning = false;

        otherwise
            disp('Invalid choice. Please enter a number from 1 to 6.');
    end
    disp(' ');   % blank line for spacing
end