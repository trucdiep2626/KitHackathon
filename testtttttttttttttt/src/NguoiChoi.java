import java.util.ArrayList;
import java.util.Scanner;

public class NguoiChoi {
    ArrayList<Nguoi> dsNguoiChoi;
    Scanner sc = new Scanner(System.in);
    public NguoiChoi() {
        dsNguoiChoi = new ArrayList<>();
    }

    void themNguoiChoi() {

        System.out.println("Nhap ten");
        String ten = sc.nextLine();
        dsNguoiChoi.add(new Nguoi(ten));
    }

    void hienThids() {
        for (int i = 0; i < dsNguoiChoi.size(); i++) {
            System.out.println("Ten : " + dsNguoiChoi.get(i).ten + " tiền :" + dsNguoiChoi.get(i).soTien);
        }
    }

    void cuocTheoLuot() {
        for (Nguoi p : dsNguoiChoi) {
            System.out.println(p.ten);
            int viTri;
            do {
                System.out.println("Nhap vi tri");
                 viTri= sc.nextInt();
            }while(viTri<0 || viTri >6);

            sc.nextLine();
            int tien;
            do {
                System.out.println("Nhap tien cuoc ");
                tien = sc.nextInt();
            } while (tien < 5000 || tien > p.soTien);
sc.nextLine();
            p.dsCuoc.add(new Cuoc(viTri, tien));

        }
    }

    void xoaNguoiChoi() {
        //for (int i = 0; i < dsNguoiChoi.size() ; i++) {
           // for (int j = 0; j < dsNguoiChoi.size(); j++) {
int i=0;

                //if (dsNguoiChoi.get(i).soTien == 0) {
                    dsNguoiChoi.removeIf(n->dsNguoiChoi.get(i).soTien == 0);
               // }
           // }

        //while(dsNguoiChoi.indexOf(dsNguoiChoi.))
    }


}
