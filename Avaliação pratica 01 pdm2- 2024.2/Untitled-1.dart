import 'package:sqlite3/sqlite3.dart';

void main() {
  final db = sqlite3.openInMemory();

  // 1. Criação da tabela TB_ALUNOS
  db.execute('''
    CREATE TABLE IF NOT EXISTS TB_ALUNOS (
      id INTEGER NOT NULL PRIMARY KEY,
      name TEXT NOT NULL,
      idade INTEGER NOT NULL
    );
  ''');
  print('Tabela TB_ALUNOS criada com sucesso.');

  // 2. Renomear tabela para TB_CONTRATADOS
  db.execute('ALTER TABLE TB_ALUNOS RENAME TO TB_CONTRATADOS;');
  print('Tabela renomeada para TB_CONTRATADOS.');

  // 3. Adicionar colunas 'originario', 'certificação' e 'linguagem'
  db.execute('ALTER TABLE TB_CONTRATADOS ADD COLUMN originario TEXT;');
  db.execute('ALTER TABLE TB_CONTRATADOS ADD COLUMN certificação TEXT;');
  db.execute('ALTER TABLE TB_CONTRATADOS ADD COLUMN linguagem TEXT;');
  print('Colunas originario, certificação e linguagem adicionadas com sucesso.');

  // 4. Inserir dados
  final stmt = db.prepare('INSERT INTO TB_CONTRATADOS (name, idade, originario, certificação, linguagem) VALUES (?, ?, ?, ?, ?)');
  stmt
    ..execute(["Andre", 21, "fortaleza", "Curso A", "Dart"])
    ..execute(["Vinijr", 25, "acarau", "Curso B", "Python"])
    ..execute(["Almeida", 19, "fortaleza", "Curso C", "Java"])
    ..execute(["Pedroca", 20, "caucaia", "Curso D", "C++"]);

  stmt.dispose();
  print('Dados inseridos na tabela TB_CONTRATADOS.');

  // 5. Buscar dados na tabela
  final resultSet = db.select('SELECT * FROM TB_CONTRATADOS');

  print('Dados na tabela TB_CONTRATADOS:');
  for (final row in resultSet) {
    print(
        'id: ${row['id']}, name: ${row['name']}, idade: ${row['idade']}, originario: ${row['originario']}, certificação: ${row['certificação']}, linguagem: ${row['linguagem']}');
  }

  // 6. Fechar banco
  db.dispose();
}