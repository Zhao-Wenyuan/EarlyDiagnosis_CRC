#' @title Distinguish between CRC and normal samples

#'

#' @description Based on SVM method and two methylation probe data, CRC early diagnosis model was constructed

#' @param Tumor
#' @param Normal
#' @param data1

#' @return test_result
#' @return pred4

#' @examples EarlyDiag_AUC(Tumor,Normal)
#' @examples EarlyDiag(data1)

#' @export

EarlyDiag_AUC<-function(Tumor,Normal){
  data(model)
  library(e1071,logical.return = T)
  library(pROC,logical.return = T)
  if(length(intersect(rownames(Tumor),makers))==2){
    tgroup_list<-factor(c(rep(1,ncol(Tumor[])),rep(2,ncol(Normal[]))),levels = c(1,2))
    test<-as.data.frame(cbind(t(cbind(Tumor[makers,],Normal[makers,])),tgroup_list))
    pred1<- predict(object = model1, newdata = test[,1:length(makers)],decision.values =TRUE)
    pred2<-attr(pred1,"decision.values")
    pred3<-sigmoid(as.matrix(pred2))#输出概率值。绘制ROC曲线
    svm_roc1 <- roc(test[names(pred1),c(length(makers)+1)],as.numeric(pred3),ci=T)
    pred4<-table(test[names(pred1),length(test[1,])], pred1)
    print(pred4)
    Sensitivity<-pred4[1,1]/sum(pred4[1,])
    Specificity<-pred4[2,2]/sum(pred4[2,])
    cat("Sensitivity=",Sensitivity,"\n")
    cat("Specificity=",Specificity,"\n")
    print(svm_roc1$auc)
    test_result<-list(model=model1,pred1=pred1,decision.values=pred2,probability=pred3,test_data=test,roc=svm_roc1)
    plot.roc(svm_roc1, legacy.axes=T,print.auc=TRUE,main=c("ROC"),collapse = "",ylim=c(0,1),xlab ="1-Specificity",ylab ="Sensitivity")
    return(test_result)

  }else{cat("Error","\n","Please check that the probe contains the required biomaker.","\n","Use biomakers() to see biomaker ID.")}

}


biomakers<-function(){
  print(data.frame(probes_ID=makers,gene_symbol=c("SDC2","SEPTIN9"),Entrenze_ID=c("6383" ,"10801")))

  cat("Please use probrs_ID")

}

EarlyDiag<-function(data1){
  data(model)
  library(e1071,logical.return = T)
  if(length(intersect(rownames(data1),makers))==2){
    test<-as.data.frame(t(data1[makers,]))
    pred1<- predict(object = model1, newdata = test[,1:length(makers)],decision.values =TRUE)
    pred2<-attr(pred1,"decision.values")
    pred3<-sigmoid(as.matrix(pred2))
    pred4<-rbind(data.frame(probability=pred3[which(pred3[,1]>=0.5),],pre_class="Tumor"),data.frame(probability=pred3[which(pred3[,1]<0.5),],pre_class="Normal"))
    return(pred4)
  }else{cat("Error","\n","Please check that the probe contains the required biomaker.","\n","Use biomakers() to see biomaker ID.")}
}
