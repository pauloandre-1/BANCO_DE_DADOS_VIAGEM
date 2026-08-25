import mysql.connector

destinos = [
    ("Paris, França", "Cidade luz, conhecida pela Torre Eiffel e museus como o Louvre"),
    ("Rio de Janeiro, Brasil", "Praias famosas, Cristo Redentor e Pão de Açúcar"),
    ("Tóquio, Japão", "Metrópole que mistura tradição e tecnologia de ponta"),
    ("Roma, Itália", "Capital histórica com Coliseu e Vaticano"),
    ("Nova York, EUA", "A cidade que nunca dorme, com Times Square e Central Park"),
    ("Machu Picchu, Peru", "Cidadela inca no topo dos Andes"),
    ("Cancún, México", "Praias de águas cristalinas no Caribe mexicano"),
    ("Santorini, Grécia", "Ilha com casas brancas e pôr do sol icônico no mar Egeu"),
    ("Bali, Indonésia", "Templos, praias e cultura balinesa"),
    ("Cidade do Cabo, África do Sul", "Paisagens entre montanha e oceano"),
]

conect = mysql.connector.connect(
    host = "IP",
    user = "User_name",
    password = "Password",
    database ="Database"


)

cursor = conect.cursor()

sql = "INSERT INTO DESTINO (NOME, DESCRICAO) VALUES (%s, %s)"

try:
    cursor.executemany(sql, destinos)
    conect.commit()
    print(f"{cursor.rowcount} destinos inseridos com sucesso!")
except mysql.connector.Error as erro:
    print(f"Erro ao Inserir: {erro}")
    conect.rollback()
finally:
    cursor.close()
    conect.close()