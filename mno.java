import java.util.Scanner;
public class mno {
	public static Scanner sc = new Scanner (System.in);
	public static void main(String[] args) {
		if (checkArray(getArray()))
			System.out.println("TAK");
		else
			System.out.println("NIE");
	}
	public static boolean checkArray(int [] a){
		int n = a.length;
		int next_index = 0;
		for (int i=0; i<n; ++i)
			if (i==0 || a[i-1] != a[i])
				a[next_index++]=a[i];
		if (a[next_index-1] == a[0]) next_index--;
		n = next_index;
		int start_point = 0;
		for (int i = 0; i < n; ++i)
			if (a[i] < a[start_point]) start_point = i;
		int [] deltas = new int[] {-1,1};
		for (int delta : deltas) {
			boolean property = true;
			for(int i = 0; i<n-1; ++i) {
				int current = (start_point + delta*i + n)%n;
				int next = (start_point + delta*(i+1) + n)%n;
				if (!(a[current]<=a[next])) {
					property = false;
					break;
				}
			}
			if (property) return true;
		}
		return false;
	}
	public static int[] getArray(){
		int size = sc.nextInt();
		int[] a = new int[size];
		for(int x=0; x<size; x++){
			a[x]=sc.nextInt();
		}
		return a;
	}
}
