public class MAIN {
    public static void main(String[] args) {
        app game = new app();
        game.nguoiChoi.themNguoiChoi();
        game.nguoiChoi.themNguoiChoi();
       // game.nguoiChoi.themNguoiChoi();
        while(true) {
            if(game.nguoiChoi.dsNguoiChoi.size()==0)
            {
                System.out.println("Them nguoi choi");
                game.nguoiChoi.themNguoiChoi();
            }
            else {
                game.nguoiChoi.hienThids();
                game.nguoiChoi.cuocTheoLuot();
                game.xoc();
                game.ghiKetQua();
                game.capNhatTien();
                game.inKetQua1();
                game.inKetQua2();
                game.nguoiChoi.xoaNguoiChoi();
                game.capNhatDSDoiTuong();
                game.nguoiChoi.hienThids();
                System.out.println("Van moi");
            }
        }
    }
}
