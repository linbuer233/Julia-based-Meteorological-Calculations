################################添加运算方法################################
import Base:/
import Base:*
import Base:-
import Base:+
import Base:exp
using Unitful

###############
-(x::Quantity,y::Number)=(x.val-y)*unit(x)

+(x::Quantity,y::Number)=(x.val+y)*unit(x)
+(x::Number,y::Quantity)=(x+y.val)*unit(y)

# *(x::Quantity,y::Number)=(x.val*y)*unit(x)
# *(x::Number,y::Quantity)=(x*y.val)*unit(y)


exp(x::Quantity) = exp(x.val)*unit(x)