use RikkeiClinicDB;
-- Phân tích: 
-- Ở đâu dữ liệu đầu vào chúng ta cần đưa vào là tổng số tiền phải trả cùng với đó là diện bệnh nhân để xem nó xét vào diện bệnh nhân gì để được giảm giá 
-- Ngoài dữ liệu đầu vào thì chúng ta cần có 2 dữ liệu đầu ra là số tiền phải trả cuối cùng và dòng thông báo 

-- Các bước xử lí 
-- Đầu tiền là chúng ta cần check xem là tổng số tiền phải trả là bao nhiêu, nếu nó là số âm thì cho nó bằng 0 và in ra thông báo 'Chi phí không hợp lệ' 
-- Còn nếu nó > 0  thì in ra thông báo là 'Đã tính toán xong'
-- Tiếp theo ta xem diện bệnh nhân là gì từ đó tính toán theo số tiền phù hợp với bệnh nhân đó 

delimiter //
create procedure payment_caculator_money (
   in total_price decimal(10,2),
   in patient_face varchar(100),
   out final_price decimal(10,2),
   out massage varchar(100)
)
begin
   if total_price < 0 then 
      set final_price = 0;
      set massage = 'Chi phí không hợp lệ';
	else
      if patient_face = 'BHYT' then set final_price = total_price * 0.2;
      elseif patient_face = 'VIP' then set final_price = total_price * 0.9;
      elseif patient_face = 'THUONG' then set final_price = total_price;
      else set massage = 'Diện bệnh nhân không có';
      end if ;
      if patient_face in ('BHYT','VIP','THUONG') then set massage = 'Đã tính toán xong';
      end if ;
	end if ;
end // 
delimiter ;

call payment_caculator_money (2000,'BHYT',@final,@massage);
select @final,@massage;
call payment_caculator_money (2000,'Vip',@final,@massage);
select @final,@massage;
call payment_caculator_money (2000,'THUONG',@final,@massage);
select @final,@massage;
call payment_caculator_money (-2000,'BHYT',@final,@massage);
select @final,@massage;
call payment_caculator_money (2000,'HELLO',@final,@massage);
select @final,@massage;