import tempfile, subprocess

template_file = open('TEMPASM.s370',mode='r')
source_file = open("ASM.s370", "w")

temp_cont = template_file.read()

source_file.write(str(temp_cont))
source_file.flush()


subprocess.run(["nano", "ASM.s370"])

subprocess.run(["./asm", "ASM"])


instr_file = open('instrdata.p',mode='rb')
code_bytes = instr_file.read()

print(code_bytes)