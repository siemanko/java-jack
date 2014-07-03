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
		boolean descending1 = false;
		boolean descending2 = false;
		for (int i=0; i<a.length-1; i++){
			int x = i+1;
			int j = a[x];
			while (x != i){
				if (j<a[i]) {
					descending1 = true;
				}
				else descending1 = false;
				if (x==a.length-1){
					x=0;
				}
				else
					x++;
			}
		}
		for (int i=a.length-1; i>0; i--){
			int x = i-1;
			int j = a[x];
			while (x != i){
				if (j<a[i]) {
					descending2 = true;
				}
				else descending2 = false;
				if (x==0){
					x=a.length-1;
				}
				else
					x--;
			}
		}
		if (descending1 || descending2)
			return true;
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