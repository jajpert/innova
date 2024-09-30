import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score, classification_report

# Carregar o CSV com os dados dos clientes
file_path = '/mnt/c/Users/jajpe/OneDrive/Documentos/testeML/clientes_treino.csv'
df = pd.read_csv(file_path)

# Separando as features e o target
X = df[['Idade', 'Tempo_assinatura_meses', 'Satisfacao']]
y = df['Assinante']

# Dividindo os dados em treino e teste
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

# Criando e treinando o modelo de Regressão Logística com pesos de classe
model = LogisticRegression(max_iter=1000, class_weight='balanced')
model.fit(X_train, y_train)

# Fazendo previsões na base de teste
y_pred = model.predict(X_test)

# Avaliando o modelo
accuracy = accuracy_score(y_test, y_pred)
classification_rep = classification_report(y_test, y_pred, output_dict=True)

# Convertendo o relatório de classificação em DataFrame
classification_df = pd.DataFrame(classification_rep).transpose()

# Salvando o relatório em um arquivo CSV
output_file = '/mnt/c/Users/jajpe/OneDrive/Documentos/testeML/relatorio_classificacao.csv'
classification_df.to_csv(output_file)

print(f'Acurácia: {accuracy}')
print(f'Relatório de Classificação salvo em: {output_file}')
