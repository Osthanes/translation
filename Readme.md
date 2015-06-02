# IBM DevOps Services Translation 

## History 
* Checked in human translation: pipeline_PII02_0519

## File format 
* For each extension there will be a Language_en.properties file that will be the source of the translation 
* Language_en.properties will be in UTF-8 encoding 
* For each extension translated files will be returned as: 
    - Language_de.properties
    - Language_fr.properties    
    - Language_ja.properties     
    - Language_pt_BR.properties  
    - Language_es.properties    
    - Language_it.properties     
    - Language_ko.properties     
    - Language_zh-CN.properties    
    - Language_zh-TW.properties
    
## Getting latest source files 
execute `bash pull_pipeline_source.sh`.  For example: 
```bash 
git clone https://github.com/Osthanes/translation.git osthanes_translation
cd osthanes_translation
./pull_pipeline_source.sh
```
source files will be located in osthanes_en_source_files.tar

## Uploading translated files via GIT 
* ensure users is added to the Osthanes organization 
* clone this repository 
* download manually translated files into local repository
* commit and push changes 

For example: 
```bash 
git clone https://github.com/Osthanes/translation.git osthanes_translation
cd osthanes_translation
```
Now download manually translated files into the appropriate directory and then: 
```bash 
git add * 
git commit -m "updating manually translated file on [date] by [person]"
git push 
```

## Uploading translated files via Globalization Delivery Service on Bluemix 
TBD 

