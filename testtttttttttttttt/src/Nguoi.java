import java.util.ArrayList;

public class Nguoi {
    String ten;
    int soTien;

    ArrayList<Cuoc> dsCuoc= new ArrayList<>();

    public Nguoi(String ten) {
        this.ten = ten;
        this.soTien = 50000;
    }

    public Nguoi() {
    }

    int capNhapTien(int[] ketQua)
    {
        for (int i = 0; i < dsCuoc.size(); i++) {
            if(ketQua[dsCuoc.get(i).viTri]!=0)
            {
                soTien+=dsCuoc.get(i).tienCuoc*ketQua[dsCuoc.get(i).viTri];
            }
            else
            {
                soTien-=dsCuoc.get(i).tienCuoc;
            }
        }
        dsCuoc.clear();
        return soTien;
    }
}
