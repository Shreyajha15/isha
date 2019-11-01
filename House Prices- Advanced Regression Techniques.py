#!/usr/bin/env python
# coding: utf-8

# In[29]:


import numpy as np # linear algebra
import pandas as pd # data processing, CSV file I/O (e.g. pd.read_csv)
import pandas_profiling as pp

train_data = pd.read_csv('./input/house-prices-advanced-regression-techniques/train.csv')

data  = train_data.copy()

# data.info()

# data.describe()

# data.head()

# any(data.isnull())

# isnull result is showing us that columnns Alley(91), FireplaceQu(770), PoolQC(7), Fence(281), MiscFeature(54)
# have missing data ranging from 50%-96%

# Hence droping columns Alley, PoolQC, Fence, MiscFeature
data = data.drop(['Alley', 'PoolQC', 'Fence', 'MiscFeature'], axis = 1) 

# sorted(data)
# Must re-look into FireplaceQu to decide whether to drop/ impute
data.FireplaceQu.unique()

# Impute LotFrontageMedian
mLotFrontageMedian = data.LotFrontage.median(skipna=True)
data["LotFrontage"].fillna(value=mLotFrontageMedian, inplace=True)

# Impute MasVnrArea
mMasVnrAreaMedian = data.MasVnrArea.median(skipna=True)
data["MasVnrArea"].fillna(value=mMasVnrAreaMedian, inplace=True)


# Impute GarageYrBlt
mGarageYrBltMedian = data.GarageYrBlt.median(skipna=True)
data["GarageYrBlt"].fillna(value=mGarageYrBltMedian, inplace=True)

# Extract all numeric columns
num_data = (data.select_dtypes(include = ['int64', 'float64']))

num_cols = list(num_data)
print("Has any Missing Values? \n")
for col in num_cols:
    print(col, ": ", any(num_data[col].isnull()))


# In[2]:


data.profile_report()


# In[30]:


# As per above Correlation matrix the following list of columns are not correlated with Target variable: SalePrice
# Hence drop-ing them

data = data.drop(['3SsnPorch', 'MiscVal', 'MoSold', 'YrSold', 'BsmtHalfBath', 'BsmtFinSF2', 'LowQualFinSF', 'Id'], axis = 1)

list(data)


# In[52]:


# Categorical Values

cat_data = data.select_dtypes(include=['object'])

cat_data.fillna('UNKNOWN', inplace=True)

cat_cols = list(cat_data)

print("Has any Missing Values? \n")
for col in cat_cols:
    print(col, ": ", any(cat_data[col].isnull()))


# In[53]:



# ONE HOT ENCODING
enc_cat_data = pd.get_dummies(
    cat_data, columns = [
        'MSZoning', 'Street', 'LotShape', 'LandContour', 'Utilities', 'LotConfig', 'LandSlope',
        'Neighborhood', 'Condition1', 'Condition2', 'BldgType', 'HouseStyle', 'RoofStyle', 'RoofMatl',
        'Exterior1st', 'Exterior2nd', 'MasVnrType', 'Foundation', 'BsmtExposure',
        'BsmtFinType1', 'BsmtFinType2', 'Heating', 'CentralAir',
        'Electrical', 'Functional', 'GarageType', 'GarageFinish',
        'PavedDrive', 'SaleType', 'SaleCondition']
)

list(data)


data = data.drop([
        'MSZoning', 'Street', 'LotShape', 'LandContour', 'Utilities', 'LotConfig', 'LandSlope',
        'Neighborhood', 'Condition1', 'Condition2', 'BldgType', 'HouseStyle', 'RoofStyle', 'RoofMatl',
        'Exterior1st', 'Exterior2nd', 'MasVnrType', 'Foundation', 'BsmtExposure',
        'BsmtFinType1', 'BsmtFinType2', 'Heating', 'CentralAir',
        'Electrical', 'Functional', 'GarageType', 'GarageFinish',
        'PavedDrive', 'SaleType', 'SaleCondition'], axis = 1)

data = pd.concat([data, enc_cat_data], axis = 1)

list(data)


# In[54]:


ordinalColNames = ['ExterQual', 'ExterCond', 'BsmtQual', 'BsmtCond', 'HeatingQC', 'KitchenQual', 'FireplaceQu', 'GarageQual', 'GarageCond']

# ['TA' 'Fa' nan 'Gd' 'Po' 'Ex']

# Create mapper
scale_mapper = {'Ex': 5, 
                'Gd': 4,
                'TA': 3,
                'Fa': 2,
                'Po': 1,
                'UNKNOWN': 0
               }
# Map feature values to scale
for col in ordinalColNames :
    data[col] = data[col].replace(scale_mapper)
    print(data[col])


# In[ ]:





# In[ ]:




