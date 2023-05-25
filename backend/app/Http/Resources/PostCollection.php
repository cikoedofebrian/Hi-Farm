<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\ResourceCollection;

class PostCollection extends ResourceCollection
{
    /**
     * Transform the resource collection into an array.
     *
     * @return array<int|string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'description' => $this->description,
            'ln' => $this->ln,
            'lt' => $this->lt,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            'tags' => PostCollection::collection($this->tags),
            'pics' => PictureCollection::collection($this->pics)
        ];
    }
}
