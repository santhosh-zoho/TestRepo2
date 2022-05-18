package Login;

public class coding {

	public static void main(String[] args) {
		int max=Integer.MIN_VALUE,temp=0,maxValue1=0,maxValue2=0,maxValue3=0;
		int [] arr= { -900,-800,700,-100,300,500,400};
		//int [] arr= { -900,-800,-700,-100,-300,-500,-400};
		int n=arr.length;
		// -1 -2 -3 -4 -5 -6 -7   -10, -3, 5, 6, -20
		for(int i=0;i<n;++i)
		{
			for(int j=i+1;j<n;++j)
			{
				if(arr[i]<arr[j])
				{
					temp=arr[i];
				    arr[i]=arr[j];
				    arr[j]=temp;
				}
			}
		}
		System.out.println("sorted array");
		for(int h:arr)
			System.out.print(h+" ");
		System.out.println();
		for(int i=0;i<n;++i)
		{
			for(int j=i+1;j<n;++j)
			{
				for(int k=j+1;k<n;++k)
				{
					temp=arr[i]*arr[j]*arr[k];
					if(temp>max) {
						max=temp;
						maxValue1=arr[i];
						maxValue2=arr[j];
						maxValue3=arr[k];
					}
					System.out.println(arr[i]+"*"+arr[j]+"*"+arr[k]+"="+temp);
				}
			}
			
		}
		System.out.println("max product using three loops is "+maxValue1+"*"+maxValue2+"*"+maxValue3+" = "+max);
		
		max=Math.max (  arr[0]*arr[1]*arr[2],   arr[0]*arr[n-1]*arr[n-2]);
		if( (arr[0]*arr[1]*arr[2]) <  (arr[0]*arr[n-1]*arr[n-2]))
		{
			max=arr[0]*arr[n-1]*arr[n-2];
			System.out.println("values = "+arr[0]+"*"+arr[n-1]+"*"+arr[n-2]);
		}
		else
		{
			max=arr[0]*arr[1]*arr[2];
			System.out.println("values = "+arr[0]+"*"+arr[1]+"*"+arr[2]);
		}
		System.out.println("max product using just a one line of code is  "+max);
		
	}

}
