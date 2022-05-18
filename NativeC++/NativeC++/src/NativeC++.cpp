#include <iostream>
#include <fstream>
#include <string>
#include "../Headers/maven_GetDataCpp.h"
using namespace std;
/*
 * Class:     test_JavaClass
 * Method:    fun
 * Signature: (Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_maven_GetDataCpp_fun(JNIEnv *env, jobject test_JavaClass , jstring jpath)
{
  const char* cpath=env->GetStringUTFChars(jpath,0);
  string Cpath=cpath;
  string Data;
  string Temp;
  ifstream MyReadFile(Cpath);
  int i=0;
  while (getline(MyReadFile,Temp))
  {
	  if(i!=0)
	   Data+="\r\n";
      Data=Data+Temp;
      ++i;
  }
  MyReadFile.close();
  jstring jdata=env->NewStringUTF(Data.c_str());
  env->ReleaseStringUTFChars(jpath,cpath);
  return jdata;
}
