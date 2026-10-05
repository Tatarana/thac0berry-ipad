# Dados em JSON

Os dados de referência (magias, kits, regras, itens…) e o formato deles (JSON Schema)
moraram aqui até 2026-10-05. Agora a fonte única é o repo
[`thac0berry-data`](https://github.com/Tatarana/thac0berry-data).

- `THAC0berry.swiftpm/Resources/*.json` é a cópia que o app carrega (o Swift
  Playgrounds precisa dos arquivos dentro do projeto). Atualize com
  `python Scripts/sync_data.py`; confira com `--check`.
- Carregamento no app: `Store/BundleJSON.swift` e os `Store/*Database.swift`.
