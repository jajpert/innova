import pandas as pd
import numpy as np


n = 500
np.random.seed(42)

data = {
    'ID_cliente': range(1, n + 1),
    'Idade': np.random.randint(18, 70, size=n),
    'Tempo_assinatura_meses': np.random.randint(1, 48, size=n),
    'Assinante': np.random.choice([0, 1], size=n, p=[0.3, 0.7]),  # 0 = não assinante, 1 = assinante
    'Satisfacao': np.random.randint(0, 6, size=n)  # Nível de satisfação de 0 a 5
}

df = pd.DataFrame(data)

file_path = '/mnt/c/Users/jajpe/OneDrive/Documentos/testeML/clientes_base.csv'
df.to_csv(file_path, index=False)

file_path
