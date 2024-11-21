if [ $BUILD_FAIL == false ]; then
   echo "🟢 success" 
   curl -X POST -H 'Content-type: application/json' --data '{"text":"🟢 Deploy success"}' https://hooks.slack.com/services/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    
else
   echo "🔴 fail"  
   curl -X POST -H 'Content-type: application/json' --data '{"text":"🔴 Deploy fail"}' https://hooks.slack.com/services/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  
fi