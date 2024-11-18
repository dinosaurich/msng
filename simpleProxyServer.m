% Путь к JAR-файлу JeroMQ
JARPATH = '/home/alex/jeromq-0.6.0/target/jeromq-0.6.0.jar';
javaclasspath(JARPATH)
import org.zeromq.*
context = ZContext();
ue_socket = context.createSocket(SocketType.REQ);
ue_socket.connect('tcp://localhost:2000');
enb_socket = context.createSocket(SocketType.REQ); 
enb_socket.connect('tcp://localhost:2001'); 
disp('Сокеты готовы. Ожидание данных...');
while true
    pause(5);
    fprintf('Wait data\n');
    ue_socket.send('Request for samples from UE', 0);
    ue_reply = ue_socket.recv(0);
    fprintf('Received from UE: [%s]\n', char(ue_reply(:)'));
    disp(ue_reply); 
    ue_samples = str2num(strrep(char(ue_reply(:)'), ',', ' '));
    disp('Преобразованные сэмплы UE:');
    disp(ue_samples);
    enb_socket.send('Request for samples from ENB', 0);
    enb_reply = enb_socket.recv(0); 
    fprintf('Received from ENB: [%s]\n', char(enb_reply(:)'));
    disp(enb_reply);
    enb_samples = str2num(strrep(char(enb_reply(:)'), ',', ' '));
    disp('Преобразованные сэмплы ENB:');
    disp(enb_samples);
    %pause(5);
end
