# import subprocess
#
script_path = '/home/acausr/myexpos/xfs-interface/xfs-interface'
data_file = '/home/acausr/myexpos/xfs-interface/sample.dat'
N = 256
#
with open(data_file, 'a') as f:
    # for i in range(1, 513):
    #     f.write('a' * 16)
    #     subprocess.run([script_path, 'load', '--data', data_file], text=True)
    #     ls_output = subprocess.run([script_path, 'ls', data_file], capture_output=True, text=True)
    #     second_line: str = ls_output.stdout.strip().split('\n')[1]
    #     size: str = second_line.split()[-1]
    #
    #     print(i * 16, 'bytes = ', size, 'words')
    #
    #     subprocess.run([script_path, 'rm', 'sample.dat'])
    f.write('a' * 16 * N)
