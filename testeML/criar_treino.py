import pandas as pd
import numpy as np

# Definindo o número de registros
n = 500
np.random.seed(42)

# Gerando dados aleatórios
data = {
    'ID_cliente': range(1, n + 1),
    'Idade': np.random.randint(18, 70, size=n),
    'Tempo_assinatura_meses': np.random.randint(1, 48, size=n),
    'Assinante': np.random.choice([0, 1], size=n, p=[0.3, 0.7]),  # 0 = não assinante, 1 = assinante
    'Satisfacao': np.random.randint(0, 6, size=n)  # Nível de satisfação de 0 a 5
}

# Criando o DataFrame
df_treino = pd.DataFrame(data)

# Salvando a nova base de treino em um arquivo CSV
treino_file_path = '/mnt/c/Users/jajpe/OneDrive/Documentos/testeML/clientes_treino.csv'
df_treino.to_csv(treino_file_path, index=False)

print(f"Arquivo de treino salvo em: {treino_file_path}")
