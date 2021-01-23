import java.sql.SQLOutput;
import java.util.ArrayList;
import java.util.Random;
import java.util.Scanner;

public class app {

    int [] ketQua = new int[3];
    int [] dsDoiTuong = {0,0,0,0,0,0};
  NguoiChoi nguoiChoi = new NguoiChoi();


    void xoc()
    {
        Random r = new Random();
        for (int i = 0; i < ketQua.length; i++) {
                ketQua[i]=r.nextInt(6);
        }
    }
    void ghiKetQua()
    {
        for (int i = 0; i < dsDoiTuong.length; i++) {
            for (int j = 0; j < ketQua.length ; j++) {
                if(i==ketQua[j])
                {
                    dsDoiTuong[i]++;
                }
            }
        }
    }
    void inKetQua1()
    {
        for (int i = 0; i < ketQua.length ; i++) {
            System.out.println(i +" "+ + ketQua[i]);
        }
    }
    void inKetQua2()
    {
        for (int i = 0; i < dsDoiTuong.length ; i++) {
            System.out.println(i+"  "+dsDoiTuong[i]);
        }
    }
    void capNhatTien()
    {
        for (int i = 0; i < nguoiChoi.dsNguoiChoi.size(); i++) {
            Nguoi p = new Nguoi();
            p.ten=nguoiChoi.dsNguoiChoi.get(i).ten;
            p.soTien=nguoiChoi.dsNguoiChoi.get(i).capNhapTien(dsDoiTuong);
            nguoiChoi.dsNguoiChoi.set(i,p) ;
        }
    }
    void capNhatDSDoiTuong()
    {
        for (int i = 0; i < dsDoiTuong.length ; i++) {
            dsDoiTuong[i]=0;
        }
    }

}
