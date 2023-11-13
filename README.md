# arm-gcc-xpack-ci

Building arm-gcc projects with xpack compilator

## Usage:

```

jobs:      
  build:
    name: Building project
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
        
      - name: make   
        uses: embedd-actions/arm-gcc-ci@v12.3.1 
        with: 
          command: make --directory Release all

```

## List of available tags

```
v12.3.1
```
