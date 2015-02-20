# mkAdminer

Scripts de automação de administração de hotspots em Mikrotik, utilizado a principio como ferramenta de aprendizagem com o github para projetos futuros.

- Para funcionamento destes scripts em Bash, é necessário um banco de dados mySQL, a principio com uma tabela apenas (hotspot.sql) com informações de ip, nome do hotspot, latitude e longitude.

- O arquivo enviaMk.sh presta-se ao envio de comandos para vários equipamentos Mikrotik já previamente cadastrados na tabela hotspot de nosso banco de dados.

- monitor.sh verifica se os mesmos pontos estão online e gera um arquivo de log
