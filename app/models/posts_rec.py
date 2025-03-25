from sklearn.neighbors import NearestNeighbors
from scipy.sparse import csr_matrix
import pandas as pd
from app.exts import _DB

class PostsRec:
    def __init__(self):
        self.make_model()
        self.read_data()

    def read_data(self):
#       into df from db
        _data =  _DB().posts.find({})

#       posts_data =  _DB().posts.find({})
#       users_data = _DB().users.find({})
#       _data = users_data.merge(posts_data, how="left", on="user_id")

#       TODO: fix data structure!

#       self._dataframe = self.spark_session.createDataFrame(_data)
        print(_data)
        rating_df = pd.DataFrame(_data, columns=['post_id', 'user_id', 'likes'])
        print(rating_df.head)
#       prep data into posts matrix as df
        df_data_features = rating_df.pivot_table(index='post_id', columns='userid', values='likes').fillna(0)
#       as scipy sparse matrix
#       TODO: issue with the matrix need to properly assign index etc
        mat_data_features = csr_matrix(df_data_features)
        self.matrix = mat_data_features

    def make_model(self):
        self.model = NearestNeighbors(metric='cosine', algorithm='brute', n_neighbors=20, n_jobs=-1)

    def recommend(self, _id, n_recs):
        self.model.fit(self.matrix)
        distances, indices = self.model.kneighbors(self.matrix[_id], n_neighbors=n_recs+1)
#        get list of raw ids of recommendations - just putting into a nicely usable list
        raw_recommends = sorted(list(zip(indices.squeeze().tolist(), distances.squeeze().tolist())),
                key=lambda x: x[1])[:0:-1]

#       raw recommends will be artist id, distance tuple
#       may want to filter out some more eg no zero distance, not repeating the same artist
        recommended_ids = [i[0] for i in raw_recommends]

        return recommended_ids

if __name__=="__main__":
    knn_recommender = PostsRec()
    print(PostsRec.recommend(8179, 10))