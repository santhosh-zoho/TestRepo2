package maven;



public class GetDataCpp {
	/*
	public static void main(String[] args) {	
		String path="C:\\Users\\Santhosh\\Desktop\\text documents\\test.txt";
		GetDataCpp cpp=new GetDataCpp();
		String Data=cpp.fun(path);
		MappingClass mc=new MappingClass();
		System.out.println(Data);
		System.out.println(mc.Mapping(Data));
	}
	*/
	static {
		System.loadLibrary("libNativeC++");
	}
	public native String fun(String path);
}
